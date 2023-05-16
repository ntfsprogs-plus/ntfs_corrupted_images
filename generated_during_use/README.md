# Corrupted Images Description

These images are not repaired with previous fsck during test.


```
1k_cluster_fsck_error/
: 1k cluster size formatted images. test for device which has cluster smaller than 4K.

attr_find_corrupt_inode/

attr_value_offset_corrupted/
: attribute value offset field corrupted.

attrlist_entry_corrupted/
: attribute list entry corrupted, so many files corrupted filename attribute,
  has wrong sequence number.

attrlist_length_corrupted/
attrlist_length_corrupted2/
attrlist_length_corrupted3/
: attribute list length corrupted, and so many files missing filename attribute,
  has wrong sequence number.

cluster_duplication_one/
: have only one cluster duplication.

corrupted_attrlist_entry_and_cluster_run/
: corrupted attribute list length, corrupted non-residentry attribute size,
  corrupted attribute list entry, corrupted lcn bitmap, corrupted cluster run entry,
  corrupted $DATA attribute.

data_size_init_size_bigger_than_alloc_size_DATA_attr/
: data and initialized size are greater than allocated size of $DATA attribute.

data_size_init_size_bigger_than_alloc_size_ia/
: data and initialized size are greater than allocated size of $INDEX_ALLOCATION attribute.

data_size_init_size_smaller_than_alloc_size_DATA_attr/
: data and initialized size are smaller than allocated size of $DATA attribute.
  it's data size of index entry and $DATA are different.

deep_depth_orphaned_files/
: has orphan files with directory depth greater than 20.

different_index_and_mft_flags/
: corrupted attribute list entry, mismatch sequence number of index entry and mft,
  corrupted $FILENAME(can't find $FILENAME)

entry_length_corrupted/
: corrupted index entry length of root.

formatted_on_windows/
: normal image which is formatted on windows.

fsck_error_remain/
: previous fsck can't repair image.
  corrupted attribute list entry, corrupted 'FILE' signature(magic) of mft.
  corrupted lcn bitmap.

has_wrong_parent_dir_in_extent_mft/
: has $FILENAME in extent mft, parent mft of $FILENAME is wrong.

highest_vcn_cluster_run/
: zero-sized data run, corrupted cluster run.
  non-zero size of directory.

idx_fn_mft_data_allocated_size_mismatch/
: allocated size of index $FILENAME and mft $FILENAME are different.

incompleted_multi_sector_transfer_after/
: image which previous fsck repair incompleted_multi_sector_transfer_before incorrectly.

incompleted_multi_sector_transfer_before/
: corrupted fix up value, deleted entries which has no $FILENAME attribute + orphan inodes.

index_block_size_corruption/
: index block signature and index block size of vcn 0 is not block size.

index_block_valid_but_index_bitmap_cleared/
: index block is valid, but index bitmap related with ib has been unset.

index_block_valid_but_index_bitmap_cleared2/
: index block is valid, but index bitmap related with IB(index block) has been unset
  + orphan inodes.

index_block_vcn_corruption/
: corrupted vcn number of IB + a lot of orphan inodes.

infinite_loop_root_dir_in_orphaned_file/
: infinite loop of fsck due to wrong algorithm.
  corrupted runlist, attribute list entry and allocated size mismatch.

ir_missing_in_parent_orphaned_file/
: orphan inodes which does not have $IR(index root)

lcn_bitmap_clear_remain/
: previous version of fsck cannot repair lcn bitmap.
  attribute list length corrupted.
  directory entries point deleted inodes.
  orphan inodes which has different sequence number with directory entry.

lostfound_corrupted/
lostfound_corrupted2/
: index entry of lost+found is corrupted
  orphan inode handling failed (cannot open lost+found directory)

memory_leak1/
: previous version of fsck has a memory leak detected by address sanitizer.
  index entry is corrupted.

mft_base_record_field_corrupted/ (deleted cause file size is too big)
: -mft base record field corrupted-
  allocated size mismatch.

mft_bitmap_corrupted/
: mft bitmap mismatch.

mft_parent_reference_corrupted/
: parent mft number and mft parent reference of inode are different.
  has a cluster duplication and orphan inodes which has wrong sequnece number.

mft_table_entry_corruption/
: $MFT is corrupted, can load $MFT.
  recover from $MFTMirr.

mismatch_index_filename/
: index filename and mft filename are different.
  orphan inode which has wrong sequence number.

mismatch_seqno_illegal_seek/
mismatch_seqno_illegal_seek3/
: sequence number of index entry and mft are different.
  orphan inodes which is been deleted and try to access non-allocated mft records.

mismatch_seqno_illegal_seek2/
: attribute list entry is corrupted.
  mft record is corrupted (FILE signature is corrupted).
  sequence number of index entry and mft are different.
  orphan inodes which is been deleted and try to access non-allocated mft records.
  orphan inodes which sequence number of index and mft are different.

missing_mft_filename_attr/
: filename attribute does not exist.
  orphan inodes which has wrong sequence number.

missing_mft_filename_attr_a_lot/
: attribute list entries are corrupted.
  filename attribute does not exist.
  orphan inodes which has corrupted attribute entry and different sequence number.

next_ie_entry_out_of_bound/
: index entry length is out of bound over total index size.
  previous version of fsck is crashed during execution.
  orphan inodes which has wrong sequence number.

not_found_filename_tntfs_unplugged/ (deleted cause file size is too big)
: corrupted image of tntfs which is unplugged during write operations.
  allocated size of index and mft are different.
  filename attribute does not exist.
  orphan inodes which has wrong sequenc number and has not filename attribute.

orphaned_inode_cant_repair/
: previous version of fsck cannot repair some case of orphaned inode.

paragon_ntfs_test1/
paragon_ntfs_test2/
paragon_ntfs_test3/
: corrupted images which has been unplugged during execution on ntfs3 filesystem.

remove_index_entry_twice/
: previous verion of fsck remove index entry twice.
  inodes whose filename does not exist and has wrong sequence number.
  orphan inodes which has wrong sequence number and has not filename attribute.

revive_orphan_mft_entry/
: orphan inodes which has wrong sequence number. repair normal orphan inodes.

root_attribute_missing_in_directory/
: previous version of fsck consider a directory which is missing $IR attribute.
  directories which has non-zero length. inode which has different allocated size.

runlist_lcn_over_max_cluster/
: runlist cluster of inode which is bigger than max cluster number.
  crashed in previous version of fsck.

runlist_mapping_pair_corrupted/
: runlist mapping is corrupted.

same_name_entries_in_orphaned_file/
: orphan inodes which has same filename entries.

usb_unplug_test_1/
: randomly unplugged images during execution.
