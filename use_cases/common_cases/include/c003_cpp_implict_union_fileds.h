struct Color
{
	static const Color sBlack;
	static const Color sWhite;

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