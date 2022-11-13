fn is_satisfied(x: usize) -> bool{
    return true
}

fn binary_search(key: i32, data: &Vec<i32>) -> i32{

    let mut left = 0;
    let mut right = data.len() - 1;
   
    while right - left > 1 {
        let mid = left + (right - left) / 2;
        if is_satisfied(mid){
            right = mid ;
        } else{
            left = mid;
        }
    }
    return right as i32
}

fn main() {
    let data: Vec<i32> = vec![3, 5, 8, 10, 14, 17, 21, 39];

    println!("{}", binary_search(10, &data));
    println!("{}", binary_search(3, &data));
    println!("{}", binary_search(39, &data));

    println!("{}", binary_search(100, &data));
    println!("{}", binary_search(125, &data));
    println!("{}", binary_search(300, &data));
}