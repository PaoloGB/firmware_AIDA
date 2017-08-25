
 add_fsm_encoding \
       {transactor_if.state} \
       { }  \
       {{000 0000001} {001 0000010} {010 0000100} {011 0010000} {100 0100000} {101 0001000} {110 1000000} }

 add_fsm_encoding \
       {transactor_sm.state} \
       { }  \
       {{000 000001} {001 000010} {010 000100} {011 001000} {100 010000} {101 100000} }

 add_fsm_encoding \
       {i2c_master_byte_ctrl.c_state} \
       { }  \
       {{00000 000} {00001 001} {00010 010} {00100 011} {01000 100} {10000 101} }

 add_fsm_encoding \
       {i2c_master_bit_ctrl.c_state} \
       { }  \
       {{00000000000000000 00000} {00000000000000001 00001} {00000000000000010 00010} {00000000000000100 00011} {00000000000001000 00100} {00000000000010000 00101} {00000000000100000 00110} {00000000001000000 00111} {00000000010000000 01000} {00000000100000000 01001} {00000001000000000 01110} {00000010000000000 01111} {00000100000000000 10000} {00001000000000000 10001} {00010000000000000 01010} {00100000000000000 01011} {01000000000000000 01100} {10000000000000000 01101} }

 add_fsm_encoding \
       {DUTInterface_EUDET.state} \
       { }  \
       {{000 000001} {001 000010} {010 000100} {011 001000} {100 010000} {101 100000} }
