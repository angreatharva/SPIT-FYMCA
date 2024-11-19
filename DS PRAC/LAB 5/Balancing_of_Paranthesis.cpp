#include <iostream>
#include <stack>
#define max 100
using namespace std;

string exp;
class BalancingParanthesis
{
public:
    void input()
    {
        cout << "Enter the Expression: ";
        cin >> exp;
    }
    void calculation()
    {
        stack<char> st;

        for (char ch : exp)
        {
            if (ch == '(')
            {
                st.push(ch);
            }
            else if (ch == ')')
            {
                st.push(ch);
                if (!st.empty())
                {
                    st.pop();
                    st.pop();
                }
            }
        }

        if (st.empty())
        {
            cout << "Expression has balanced Parenthesis";
        }
        else
        {
            cout << "Expression does not has balanced Parenthesis";
        }
    }
};

int main()
{
    BalancingParanthesis bp;
    bp.input();
    bp.calculation();
    return 0;
}
