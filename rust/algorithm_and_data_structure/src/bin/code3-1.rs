use common;

fn main() {

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input_usize();

    println!("Type each data: ");
    let mut data = Vec::with_capacity(n);
    data.resize(n, 0);
    for i in 0..n {data[i] = common::read_input_u64();}

    println!("Type target data: ");
    let v: u64 = common::read_input_u64();

    // Check input data
    println!("Input data:");
    for val in data.iter() {
        println!("{}", val);
    }

    // Initialization with false
    let mut exist = false;
    for val in data.iter() {
        if val == &v {
            exist = true;
        }
    }

    if exist {
        println!("Yes");
    }
    else{
        println!("No");
    }
}