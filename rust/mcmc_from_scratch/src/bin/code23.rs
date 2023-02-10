use rand::prelude::*;

fn main() {
    let niter = 100000;

    let pi = (1 as f64).asin() * 2.0;
    let mut sum_z = 0.0;
    let mut n_in = 0;
    let mut rng = thread_rng();
    for _iter in 1..niter{
        let x: f64 = rng.gen(); // random number in range [0, 1)
        let y: f64 = rng.gen(); // random number in range [0, 1)

        if x*x + y*y < 1.0{
            n_in = n_in + 1;
            let z = (1.0 - x * x - y * y).sqrt();
            sum_z = sum_z + z;
        }

        println!("{0} {1}", _iter, sum_z / n_in as f64 * 2.0 * pi);
    }
}
