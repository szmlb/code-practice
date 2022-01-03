fn binary_search(key: usize, arr: &mut Vec<usize>) -> usize{

    let mut left: usize = 0;
    let mut right: usize = arr.len() - 1;
    while right >= left {
        let mid = left + (right - left) / 2;
        if arr[mid] == key {return mid;}
        else if arr[mid] > key {right = mid - 1;}
        else if arr[mid] < key {left = mid + 1;}
    }
    return usize::MAX;
}

fn main() {
    let n: usize = 8;
    let mut arr: Vec<usize> = Vec::with_capacity(n);
    arr.resize(n, 0);
    arr[0] = 3;
    arr[1] = 5;
    arr[2] = 8;
    arr[3] = 10;
    arr[4] = 14;
    arr[5] = 17;
    arr[6] = 21;
    arr[7] = 39;

    println!("{}", binary_search(10, &mut arr));
    println!("{}", binary_search(3, &mut arr));
    println!("{}", binary_search(39, &mut arr));

    println!("{}", binary_search(100, &mut arr));
    println!("{}", binary_search(125, &mut arr));
    println!("{}", binary_search(300, &mut arr));
}