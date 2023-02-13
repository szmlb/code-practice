use rand::prelude::*;

fn main() {
    let niter = 100000;
    let step_size_x = 0.5;
    let step_size_y = 0.5;

    let mut x = 0.0;
    let mut y = 0.0;
    let mut naccept  = 0;
    let mut rng = thread_rng();

    let mut sum_x = 0.0;
    let mut sum_x_squared = 0.0;
    let mut sum_y = 0.0;
    let mut sum_y_squared = 0.0;

    for _iter in 1..niter{
        let backup_x = x;
        let backup_y = y;

        let action_init = 0.5 * (x * x + y * y + x * y);
        let mut dx: f64 = rng.gen(); // random number in range [0, 1)
        let mut dy: f64 = rng.gen(); // random number in range [0, 1)

        dx = (dx - 0.5) * step_size_x * 2.0;
        dy = (dy - 0.5) * step_size_y * 2.0;

        x = x + dx;
        y = y + dy;

        let action_fin = 0.5 * (x * x + y * y + x * y);
        
        let metropolis: f64 = rng.gen(); // random number in range [0, 1)
        if (action_init - action_fin).exp() > metropolis{
            naccept = naccept + 1;
        }
        else{
            x = backup_x;
            y = backup_y;
        }

        sum_x = sum_x + x;
        sum_y = sum_y + y;

        sum_x_squared = sum_x_squared + x * x;
        sum_y_squared = sum_y_squared + y * y;

        if _iter % 10 == 0{
            println!("{0} {1} {2} {3} {4}", sum_x / niter as f64, sum_y / niter as f64, sum_x_squared / niter as f64, sum_y_squared / niter as f64, naccept as f64 / niter as f64);
        }
    }
}