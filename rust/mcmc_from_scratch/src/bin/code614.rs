use rand::prelude::*;

fn calc_box_muller(p: &mut f64, q: &mut f64){

     let pi = (1 as f64).asin() * 2.0;

    let mut rng = thread_rng();
    let r: f64 = rng.gen(); // random number in range [0, 1)
    let s: f64 = rng.gen(); // random number in range [0, 1)

    *p = (-2.0 * r.log10()).sqrt() * (2.0 * pi * s).sin();
    *q = (-2.0 * r.log10()).sqrt() * (2.0 * pi * s).cos();
}

fn main() {
    let mut p = 0.0;
    let mut q = 0.0;
    calc_box_muller(&mut p, &mut q);
    println!("{0} {1}", p, q);
}