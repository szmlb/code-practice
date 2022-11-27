use common;

fn main() {

    // test example
    // n=3, k=10, a=(8, 5, 4), b=(4, 1, 9)

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

    // Sort
    data_b.sort();

    // Find minimum
    // Linear search
    let mut min_value = std::u64::MAX;
    for i in 0..n
    {
        // fin the minimum value which is equal or greater than K - a[i]
        let index_of_lower_bound = data_b.iter().position(|x| x >= &(k - data_a[i]));

        // get the minimum value
        let val = data_b[index_of_lower_bound.unwrap()];

        // compare with min_value
        if data_a[i] + val < min_value{
            min_value = data_a[i] + val;
        }

    }

    println!("{}", min_value);
}