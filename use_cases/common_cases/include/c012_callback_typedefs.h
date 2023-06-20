#include "stdlib.h"

struct a;
struct SomeStruct;

typedef int     (*NoArgsCallback)();
typedef int     (*SingleLetterCallback)(a);
typedef void    (*NamedParam)(const SomeStruct const* data);

struct ImGuiInputTextCallbackData;
struct ImGuiSizeCallbackData;

typedef int     (*ImGuiInputTextCallback)(ImGuiInputTextCallbackData* data);
typedef void    (*ImGuiSizeCallback)(ImGuiSizeCallbackData* data);
typedef void*   (*ImGuiMemAllocFunc)(size_t sz, void* user_data);
typedef void    (*ImGuiMemFreeFunc)(void* ptr, void* user_data);