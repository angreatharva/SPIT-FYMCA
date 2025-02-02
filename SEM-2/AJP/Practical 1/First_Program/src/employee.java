class employee {
    private int employeeNumber;
    private String employeeName;
    protected int salary;

    public void getData(int empno, String empname) {
        employeeNumber = empno;
        employeeName = empname;
    }

    public void putData() {
        System.out.println("Employee Number: " + employeeNumber);
        System.out.println("Employee Name: " + employeeName);
        System.out.println("Employee Salary: " + salary);
    }

    public static void main(String[] args) {
        // Hourly Basis Employee
        System.out.println("\n*Hourly Basis Employee*");
        hourlyBasis hourlyBasisEmployee = new hourlyBasis();
        hourlyBasisEmployee.getData(1, "Atharva");
        hourlyBasisEmployee.getHourlyData(1, 800);
        hourlyBasisEmployee.calculate();
        System.out.println("Hourly Basis Employee Details:");
        hourlyBasisEmployee.putData();

        // Monthly Basis Employee
        System.out.println("\n*Monthly Basis Employee*");
        monthlyBasis monthlyBasisEmployee = new monthlyBasis();
        monthlyBasisEmployee.getData(2, "Adam");
        monthlyBasisEmployee.getMonthlyData(15000, 10, 1);
        monthlyBasisEmployee.calculate();
        System.out.println("\nMonthly Basis Employee Details:");
        monthlyBasisEmployee.putData();
    }
}

class hourlyBasis extends employee {
    private int hours;
    private int rate;

    public void getHourlyData(int h, int r) {
        hours = h;
        rate = r;
    }

    public void calculate() {
        salary = hours * rate;
    }
}

class monthlyBasis extends employee {
    private int basic;
    private int hra;
    private int da;

    public void getMonthlyData(int b, int h, int d) {
        basic = b;
        hra = h;
        da = d;
    }

    public void calculate() {
        salary = basic + (basic * hra / 100) + (basic * da / 100);
    }

}

