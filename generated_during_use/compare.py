import os
import filecmp
import logging
import argparse as ap
import time

windows_meta = {'$RECYCLE.BIN', 'System Volume Information', 'found.000', 'found.001'}
ntfsprogs_meta = {'lost+found'}

args = ''
def parse_argument():
    global args

    desc = "Comparison with windows repaired and ntfsprogs-plus repaired images"
    path_help = "image path to compare"
    mnt_help1 = "1st mount point path"
    mnt_help2 = "2nd mount point path"
    log_help2 = "comparison result log file"
    parser = ap.ArgumentParser(description=desc)
    parser.add_argument("path", metavar='<image path>', help=path_help)
    parser.add_argument("mntpnt1", metavar='<mount point1>', help=mnt_help1)
    parser.add_argument("mntpnt2", metavar='<mount point2>', help=mnt_help2)
    parser.add_argument("logfile", metavar='<log filename>', help=log_help2)

    try:
        args = parser.parse_args()
    except ap.ArgumentError as e:
        print(e.message + '\n' + e.argument)
        parser.print_help()
        exit(-1)

    return args

def mount_filesystem(mount_point, source):
    return os.system(f'sudo mount {source} {mount_point}')

def unmount_filesystem(mount_point):
    return os.system(f'sudo umount {mount_point}')

def compare_directories(dir1, dir2, path):
    comparison = filecmp.dircmp(dir1, dir2)
    logging.info("------------------------------------------------")
    logging.info("Comparison Result: {}".format(path))
    ret = log_differences(comparison)
    logging.info("------------------------------------------------")
    if ret:
        return ret

def log_differences(comparison):
    ret1 = ret2 = 0
    left_only_set = set(comparison.left_only)
    right_only_set = set(comparison.right_only)
    if comparison.left_only:
        logging.info(f"  Only in {comparison.left}: {comparison.left_only}")
        if left_only_set - windows_meta:
            ret1 = 1
    if comparison.right_only:
        logging.info(f"  Only in {comparison.right}: {comparison.right_only}")
        if right_only_set - ntfsprogs_meta:
            ret1 = 1
    if comparison.diff_files:
        logging.info(f"  Different files: {comparison.diff_files}")
    if comparison.funny_files:
        logging.info(f"  Funny files: {comparison.funny_files}")

    for subdir in comparison.subdirs.values():
        ret2 = log_differences(subdir)

    return ret1 or ret2

def main():
    parse_argument()
    mount_point1 = args.mntpnt1
    mount_point2 = args.mntpnt2
    path = args.path
    logfile = args.logfile
    win_img = "{}/{}".format(path, 'windows_repaired.img')
    ntfsprogs_img = "{}/{}".format(path, 'ntfs.img')

    # 로그 설정
    logging.basicConfig(filename=logfile, level=logging.INFO, format='%(asctime)s - %(message)s')

    # 파일 시스템 마운트
    ret = mount_filesystem(mount_point1, win_img)
    if ret:
        print(f"mount {mount_point1} failed. Try to do again with 'sudo'")
        exit(1)

    ret = mount_filesystem(mount_point2, ntfsprogs_img)
    if ret:
        print(f"mount {mount_point2} failed. Try to do again with 'sudo'")
        exit(1)

    try:
        # 디렉토리 비교
        ret = compare_directories(mount_point1, mount_point2, path)
    except Exception as e:
        ret = e >> 8
        print(f"mount {mount_point1} failed.: {ret}")

    finally:
        # 파일 시스템 언마운트
        time.sleep(1)
        unmount_filesystem(mount_point1)
        unmount_filesystem(mount_point2)
        if ret:
            exit(1)

if __name__ == "__main__":
    main()
