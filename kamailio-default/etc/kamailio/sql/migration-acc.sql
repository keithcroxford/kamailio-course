ALTER table acc_cdrs
ADD COLUMN (
    src_user VARCHAR(255),
    src_ip VARCHAR(255),
    src_domain VARCHAR(255),
    dst_user VARCHAR(255),
    call_id VARCHAR(255)
);


