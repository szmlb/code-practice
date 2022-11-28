use std::convert::TryInto;

use common;

fn main() {

    // test example
    // n=3, k=10, a=(8, 5, 4), b=(4, 1, 9)

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input_usize();

    println!("Type each data: ");
    let mut data_h = Vec::with_capacity(n);
    let mut data_s = Vec::with_capacity(n);
    data_h.resize(n, 0);
    data_s.resize(n, 0);
    for i in 0..n {data_h[i] = common::read_input_u64();}
    for i in 0..n {data_s[i] = common::read_input_u64();}

    // Check input data
    println!("Input data:");
    for val in data_h.iter() { println!("{}", val);}
    for val in data_s.iter() { println!("{}", val);}

    // Find minimum
    let mut left = 0;
    let mut right = std::u64::MAX;

    while right - left > 1 {
        let mid = (left + right) / 2;

        // check
        let mut ok = true;

        let mut data_t = Vec::with_capacity(n);
        data_t.resize(n, 0);

        for i in 0..n
        {
            if mid < data_h[i] {
                ok = false;
            }
            else {
                data_t[i] = (mid - data_h[i]) / data_s[i]; 
            }
        }

        // Sort
        data_t.sort();

        for i in 0..n
        {
            if data_t[i] < i.try_into().unwrap() {
                ok = false;
            }
        }

        if ok {
            right = mid
        }else{
            left = mid;
        }
    }
    println!("{}", right);

}