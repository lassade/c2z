typedef struct Bitfields
{
    unsigned long long bitfield1 : 10;
    unsigned long long bitfield2 : 10;
    unsigned long      bitfield3 : 5;
    signed long        bitfield4 : 5;
    bool               bitfield5 : 2;
    char               bitfield6 : 2;
    unsigned char      bitfield7 : 2;
    int                bitfield8 : 31;
    long long          bitfield9 : 30;
    // TODO: Add test of 0-length bitfield here
    // long long : 0;
    long long          bitfield11 : 30;
} Bitfields;

int size_of_Bitfields();
