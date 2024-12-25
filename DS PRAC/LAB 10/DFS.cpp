#include <iostream>
#include <vector>
#include <stack>
using namespace std;

class DFS
{
public:
    void dfsTraversal(int start, int nodes, const vector<vector<int>> &arr)
    {
        vector<bool> visited(nodes, false);
        stack<int> s;
        s.push(start);

        cout << "DFS Traversal: ";
        while (!s.empty())
        {
            int current = s.top();
            s.pop();

            if (!visited[current])
            {
                cout << (char)('A' + current) << " ";
                visited[current] = true;
            }
            for (int i = 0; i < nodes; i++)
            {
                if (arr[current][i] == 1 && !visited[i])
                {
                    s.push(i);
                }
            }
        }
        cout << endl;
    }
};

int main()
{
    int nodes;
    cout << "How many nodes: ";
    cin >> nodes;

    vector<vector<int>> arr(nodes, vector<int>(nodes));
    for (int i = 0; i < nodes; i++)
    {
        for (int j = 0; j < nodes; j++)
        {
            cout << (char)('A' + i) << " to " << (char)('A' + j) << ": ";
            cin >> arr[i][j];
        }
    }

    char startNode;
    cout << "\nEnter the starting node: ";
    cin >> startNode;
    int startIndex = startNode - 'A';

    if (startIndex >= 0 && startIndex < nodes)
    {
        DFS dfs;
        dfs.dfsTraversal(startIndex, nodes, arr);
    }
    else
    {
        cout << "Invalid starting node." << endl;
    }

    return 0;
}

// 0 1 1 1 0 0 1 0 0 0 1 0 1 0 0 0 1 0 1 0 0 0 0 1 0 1 1 0 0 1 0 0 0 1 1 0