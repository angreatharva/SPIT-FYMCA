import java.awt.*;

public class Pellet {
    private int x, y;
    private boolean eaten;

    public Pellet(int x, int y) {
        this.x = x;
        this.y = y;
        this.eaten = false;
    }

    public void draw(Graphics g) {
        if (!eaten) {
            g.setColor(Color.WHITE);
            g.fillOval(x * 20 + 8, y * 20 + 8, 4, 4); // Small dot for pellet
        }
    }

    public boolean isEatenBy(int pacmanX, int pacmanY) {
        if (x == pacmanX && y == pacmanY && !eaten) {
            eaten = true;
            return true;
        }
        return false;
    }
}
