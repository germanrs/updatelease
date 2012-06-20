\ OLPC actos

visible

: unsecure-load-ramdisk ( -- )
  0 to /ramdisk

  ['] load-path behavior>r ( r: xt )
  ['] ramdisk-buf to load-path ( r: xt )

  " rd" bundle-present? if
     r>  to load-path
     img$ place-ramdisk
     exit
  then
  r>  to load-path
;
: boot-actos ( -- )
  " int:" dn-buf place
  " \boot" pn-buf place
  " act" cn-buf place
  " os" bundle-present?  if
     oskey$ to pubkey$
     img$ sig$ sha-valid?  if
        img$ tuck load-base swap move !load-size
        ['] secure-load-ramdisk to load-ramdisk
        " init-program" $find if ( xt )
           set-cmdline
           execute
           sound-end
           go
        then
     else
        ." Signature invalid" cr
     then
  then
;
boot-actos
