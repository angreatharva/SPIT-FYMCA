#include <iostream>
#include <vector>
#include <queue>
using namespace std;

class BFS
{
public:
    void bfsTraversal(int start, int nodes, const vector<vector<int>> &arr)
    {
        vector<bool> visited(nodes, false);
        queue<int> q;
        q.push(start);
        visited[start] = true;

        cout << "BFS Traversal: ";
        while (!q.empty())
        {
            int current = q.front();
            q.pop();
            cout << (char)('A' + current) << " ";

            for (int i = 0; i < nodes; i++)
            {
                if (arr[current][i] == 1 && !visited[i])
                {
                    q.push(i);
                    visited[i] = true;
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
    cout << "\nEnter the starting node : ";
    cin >> startNode;
    int startIndex = startNode - 'A';

    if (startIndex >= 0 && startIndex < nodes)
    {
        BFS bfs;
        bfs.bfsTraversal(startIndex, nodes, arr);
    }
    else
    {
        cout << "Invalid starting node." << endl;
    }

    return 0;
}

// 0 1 1 1 0 0 1 0 0 0 1 0 1 0 0 0 1 0 1 0 0 0 0 1 0 1 1 0 0 1 0 0 0 1 1 0