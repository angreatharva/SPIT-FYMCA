class employee1 {
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
}

class hourlyBasis1 extends employee {
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

class monthlyBasis1 extends employee {
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
