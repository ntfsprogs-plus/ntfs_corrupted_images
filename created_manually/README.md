# Image Descriptions
These images are created manually for testing

```
bs_bytes_per_sector:
 ntfs.img has wrong sector size 500.
 valid sector size is 256, 512, 1024, 2048, 4096.

bs_filesystem_signature:
 ntfs.img has wrong filesystem signature "NTF     " instead of "NTFS    ".

bs_index_entry_size:
 ntfs.img has wrong index per cluster size. 7

bs_index_record_size:
 ntfs.img has wrong index per cluster size. 7

bs_mft_cluster_number:
 ntfs.img has wrong mft cluster number 0x355 -> -0x5(negative)

bs_mft_record_size:
 ntfs.img has wrong mft record size 0xF6 -> 0x30

bs_mftmirror_cluster_number:
 ntfs.img has wrong mftmirror cluster number 0x02 -> 0x355(same as mft cluster number)

bs_sector_per_cluster:
 ntfs.img has wrong sector\_per\_cluster size 127.

bs_sector_signature:
 ntfs.img has wrong sector signature 0xAA55 -> 0x55AA

bs_total_sectors:
 ntfs.img has wrong total sectors 0x4FF -> 0x64

mft_attr_bad_fields:

mft_bitmap_unset_mft_in_use:
 /dir.00/file.0(65): in-use mft record and index entry exists, but not set in mft bitmap

mft_bitmap_unset_mft_in_use2:
 /dir.00/file.0(65): in-use mft record, but index entry does not exist and not set in mft bitmap

mft_file_bad_base_mft_record:

mft_file_bad_fixup_value_count:

mft_file_bad_fixup_value_offset:

mft_file_bad_link_count:

mft_file_bad_sequence_number:

mft_file_corrupt_attrlist:

mft_file_mnissing_bitmap_attr:

mft_file_missing_data_attr:

mft_file_missing_filename_attr:

mft_non_attr_bad_fields:

mft_record_bad_fields:
 /dir.00/file.0: signature: 0xFF (0x454c5966)
 /dir.00/file.1: fix-up value offset: 0x2F(0x30)
 /dir.00/file.2: number of fix-up values: 0x2(0x3)
 /dir.00/file.3: sequence: 0 (1)
 /dir.00/file.4: reference count: 0 (1)
 /dir.00/file.5: attribute offset:  0x38 (0x30)
 /dir.00/file.6: entry flags: 0x1 (0xFF)
 /dir.00/file.7: used entry size: 0x170 (0x160)
 /dir.00/file.8: total entry size: 0x3FF	(0x400)
 /dir.00/file.9: base record file reference: 0x1 (0x0)
 /dir.00/file.10: first available attribute identifier: 0x1 (0x4)