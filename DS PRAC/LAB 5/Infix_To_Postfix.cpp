#include <iostream>
#include <stack>
#include <string>
#include <iomanip>
using namespace std;

string infixExpression;
int step = 1;

class InfixToPostfix
{
public:
    void input()
    {
        cout << "Enter an infix expression: ";
        cin >> infixExpression;
    }

    void conversion()
    {
        string postfixExpression = infixToPostfix(infixExpression);
        cout << "\nPostfix expression: " << postfixExpression << endl;
    }

    int precedence(char op)
    {
        if (op == '-')
            return 1;
        if (op == '+')
            return 2;
        if (op == '*')
            return 3;
        if (op == '/')
            return 4;
        if (op == '^')
            return 5;
        return 0;
    }

    bool isOperator(char ch)
    {
        return ch == '+' || ch == '-' || ch == '*' || ch == '/';
    }

    string infixToPostfix(string Q)
    {
        stack<char> st;
        string P;

        // Step 1: Push '(' onto the stack and add ')' to the end of Q
        st.push('(');
        Q += ')';

        // Print table header
        cout << setw(10) << "Symbol"
             << setw(25) << "Stack"
             << setw(20) << "Expression" << endl;
        cout << string(70, '-') << endl;

        // Step 1: iterate Q from left to right
        for (char ch : Q)
        {
            // Step 3: If operand, add it to P
            if (isalnum(ch))
            {
                P += ch;
            }
            // Step 4: If left parenthesis, push onto stack
            else if (ch == '(')
            {
                st.push(ch);
            }
            // Step 5: If operator is encountered
            else if (isOperator(ch))
            {
                while (!st.empty() && precedence(st.top()) >= precedence(ch))
                {
                    P += st.top();
                    st.pop();
                }
                st.push(ch);
            }
            // Step 6: If right parenthesis is encountered
            else if (ch == ')')
            {
                while (!st.empty() && st.top() != '(')
                {
                    P += st.top();
                    st.pop();
                }
                st.pop(); // Remove the left parenthesis
            }

            // Print current step details
            cout << setw(10) << step++
                 << setw(25) << getStackContents(st)
                 << setw(20) << P << endl;
        }

        return P; // Return the postfix expression
    }

    string getStackContents(stack<char> st)
    {
        string contents;
        while (!st.empty())
        {
            contents += st.top();
            st.pop();
        }
        return contents;
    }
};

int main()
{
    InfixToPostfix itp;
    itp.input();
    itp.conversion();

    return 0;
}
