use rand::prelude::*;

fn main() {
    let niter = 10000;

    let mut n_in = 0;
    let mut rng = thread_rng();
    for _iter in 1..niter{
        let x: f64 = rng.gen(); // random number in range [0, 1)
        let y: f64 = rng.gen(); // random number in range [0, 1)

        if x*x + y*y < 1.0{
            n_in = n_in + 1;
        }
        println!("{0}   {1}", _iter, n_in as f64 / _iter as f64);
    }
}
