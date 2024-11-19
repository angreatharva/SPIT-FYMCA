#include <iostream>
#define max 100
using namespace std;

int i = 0, n, ch, arr[max], key;
string exp;
class PostfixEvaluation
{
public:
    void input()
    {
        cout << "Enter the Expression: ";
        cin >> exp;
    }
    void conversion()
    {
    }
};

int main()
{
    PostfixEvaluation pe;
    pe.input();
    pe.conversion();
    return 0;
}
