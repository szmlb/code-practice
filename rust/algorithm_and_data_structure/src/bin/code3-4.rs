use common;

fn main() {

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input_usize();

    println!("Type a minimum sum number: ");
    let k: u64 = common::read_input_u64();

    println!("Type each data: ");
    let mut data_a = Vec::with_capacity(n);
    let mut data_b = Vec::with_capacity(n);
    data_a.resize(n, 0);
    data_b.resize(n, 0);
    for i in 0..n {data_a[i] = common::read_input_u64();}
    for i in 0..n {data_b[i] = common::read_input_u64();}

    // Check input data
    println!("Input data:");
    for val in data_a.iter() { println!("{}", val);}
    for val in data_b.iter() { println!("{}", val);}

    // Find minimum
    // Linear search
    let mut min_value = std::u64::MAX;
    for i in 0..n
    {
        for j in 0..n
        {
            // continue if sum is smaller than value k
            if data_a[i] + data_b[j] < k {
                continue;
            }

            // update minimum value
            if data_a[i] + data_b[j] < min_value {
                min_value = data_a[i] + data_b[j];
            }

        }
    }

    println!("{}", min_value);
}