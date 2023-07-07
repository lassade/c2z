
struct ImVec2 {
    float x, y;

    ImVec2();
    ImVec2(float x, float y);

    float& operator[](int idx);
    float  operator[](int idx) const;

    ImVec2  operator*(const float rhs) const;
    ImVec2& operator*=(const float rhs);

    ImVec2  operator/(const float rhs) const;
    ImVec2& operator/=(const float rhs);
    
    ImVec2  operator+(const ImVec2& rhs) const;
    ImVec2& operator+=(const ImVec2& rhs);
    
    ImVec2  operator-(const ImVec2& rhs) const;
    ImVec2& operator-=(const ImVec2& rhs);
};

struct ImVec4 {
    float x, y, y, z;
};

static ImVec4 operator+(const ImVec4& lhs, const ImVec4& rhs);
static ImVec4 operator-(const ImVec4& lhs, const ImVec4& rhs);
static ImVec4 operator*(const ImVec4& lhs, const ImVec4& rhs);
