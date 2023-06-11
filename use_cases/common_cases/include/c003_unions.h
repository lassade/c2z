union Color32
{
	unsigned int mU32;
	struct
	{
		unsigned char r;
		unsigned char g;
		unsigned char b;
		unsigned char a;
	};
};

struct ColorClass
{
	static const ColorClass sBlack;
	static const ColorClass sWhite;

	union
	{
		unsigned int mU32;
		struct
		{
			unsigned char r;
			unsigned char g;
			unsigned char b;
			unsigned char a;
		};
	};
};