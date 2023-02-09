use rand::prelude::*;

fn main() {
    let niter = 10000;

    let mut sum_y = 0.0;
    let mut iter = 0;
    let mut rng = thread_rng();
    for _iter in 1..niter{
        let x: f64 = rng.gen(); // random number in range [0, 1)
        let y = (1.0 - x * x).sqrt();
        sum_y = sum_y + y;

        println!("{0}   {1}", _iter, sum_y / _iter as f64);
    }
}
