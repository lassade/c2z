typedef struct Bitfields
{
    unsigned long long bitfield1 : 10;
    unsigned long long bitfield2 : 10;
    unsigned long      bitfield3 : 5;
    signed long        bitfield4 : 5;
    bool               bitfield5 : 2;
    char               bitfield6 : 2;
    unsigned char      bitfield6 : 2;
    int                bitfield7 : 31;
    long long          bitfield8 : 30;
} Bitfields;
