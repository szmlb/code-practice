use common;

fn main() {

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input_usize();

    println!("Type a minimum sum number: ");
    let w: i64 = common::read_input_i64();

    println!("Type each data: ");
    let mut data_a: Vec<i64> = Vec::with_capacity(n);
    data_a.resize(n, 0);
    for i in 0..n {data_a[i] = common::read_input_i64();}

    // Check input data
    println!("Input data:");
    for val in data_a.iter() { println!("{}", val);}

    if func(n, w, &mut data_a)
    {
         println!("Yes");
    }
    else
    {
        println!("No");
    }

}

fn func(n: usize, w: i64, data: &mut Vec<i64>) -> bool{

    // base case
    if n == 0
    {
        if w == 0
        {
            return true;
        }
        else{
            return false;
        }
    } 

    // In case a[n - 1] is not chosen
    if func(n-1, w, data)
    {
        return true;
    }

    // In case a[n - 1] is chosen
    if func(n-1, w-data[n-1], data)
    {
        return true;
    }

    return false;
}