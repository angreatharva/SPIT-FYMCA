public class Main {
    public static void main(String[] args) {
        TSPBranchAndBound solver = new TSPBranchAndBound();
        solver.readInput();
        solver.solve();
        solver.printResult();
    }
}
//0 24 42 35
//        20 0 30 34
//        42 30 0 12
//        35 34 12 0

