use common;

fn main() {

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input_usize();

    println!("Type a minimum sum number: ");
    let w: u64 = common::read_input_u64();

    println!("Type each data: ");
    let mut data_a = Vec::with_capacity(n);
    data_a.resize(n, 0);
    for i in 0..n {data_a[i] = common::read_input_u64();}

    // Check input data
    println!("Input data:");
    for val in data_a.iter() { println!("{}", val);}

    // bit is supposed to search 2^n number of whole subset
    let mut exist = false;
    for bit in 0..(1 << n)
    {
            let mut sum: u64 = 0; // Sum of elements in each subset
            for i in 0..n
            {
                // Check if data_a[i] is included in subset
                if (bit & (1 << i)) != 0 {
                    sum = sum + data_a[i];
                }
            }

           // Check if sum is equal to input value w
            if sum == w {
                exist = true;
            }
    }

    if exist 
    {
        println!("Yes");
    }
    else
    {
        println!("No");
    }
}