use rand::prelude::*;

fn main() {
    let niter = 100000;
    let step_size = 0.5;

    let mut x = 0.0;
    let mut naccept  = 0;
    let mut rng = thread_rng();

    let mut sum_x = 0.0;
    let mut sum_x_squared = 0.0;
    for _iter in 1..niter{
        let backup_x = x;
        let action_init = 0.5 * x * x;
        let mut dx: f64 = rng.gen(); // random number in range [0, 1)

        dx = (dx - 0.5) * step_size * 2.0;
        x = x + dx;

        let action_fin = 0.5 * x * x;
        
        let metropolis: f64 = rng.gen(); // random number in range [0, 1)
        if (action_init - action_fin).exp() > metropolis{
            naccept = naccept + 1;
        }
        else{
            x = backup_x;
        }

        sum_x = sum_x + x;
        sum_x_squared = sum_x_squared + x * x;

        println!("{0} {1} {2}", sum_x / niter as f64, sum_x_squared / niter as f64, naccept as f64 / niter as f64);
    }
}
