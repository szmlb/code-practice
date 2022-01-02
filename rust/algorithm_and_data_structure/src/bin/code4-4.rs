fn main() {

    println!("{}", gcd(51, 15));
    assert_eq!(gcd(51, 15), 3);

    println!("{}", gcd(15, 51));
    assert_eq!(gcd(15, 51), 3);

}

fn gcd(m: u64, n: u64) -> u64{

    // Base case
    if n == 0
    {
        return m;
    } 

    // Recursive call
    return gcd(n, m % n);
}