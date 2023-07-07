#include "c022_cpp_string.h"

int size_of_string()
{
    return sizeof(std::string);
}

const char *data(const std::string &input)
{
    return input.data();
}

const char *cstr(const std::string &input)
{
    return input.c_str();
}

int cap(const std::string &input)
{
    return (int)input.capacity();
}

std::string get_str()
{
    return std::string("Hello, World!");
}

bool write_numbers(std::string &output, size_t count)
{
    if (output.length() > 0)
    {
        output.push_back(',');
        output.push_back(' ');
    }

    for (size_t i = 0; i < count; i++)
    {
        output.push_back('0' + i);
        if (i < (count - 1))
        {
            output.push_back(',');
            output.push_back(' ');
        }
    }

    return true;
}
