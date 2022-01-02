use common;
use ndarray::Array2;

fn chmin<T: Ord>(a: T, b: T) -> T{
    if a > b
    {
        return b
    }
    else
    {
        return a
    }
}

fn main() {

    // example:
    // s_word: logistic
    // t_word: algorithm
    // ans = 6

    // initialize variable for storing an answer, with INF
    let inf = 1 << 29;

    // Get input
    println!("Type 1st word: ");
    let mut s_word = String::new();
    common::read_input_string(&mut s_word);
    let s_word_vec: Vec<char> = s_word.chars().collect();

    println!("Type 2nd word: ");
    let mut t_word = String::new();
    common::read_input_string(&mut t_word);
    let t_word_vec: Vec<char> = t_word.chars().collect();

    // A table for input data / memo
    let mut dp = Array2::<i64>::zeros((s_word_vec.len()+1, t_word_vec.len()+1));
    for i in 0..s_word_vec.len()+1 {
        for j in 0..t_word_vec.len()+1 {
            dp[[i, j]] = inf;
        }
    }
    dp[[0, 0]] = 0;

    // DP loop
    for i in 0..s_word_vec.len()+1 {
        for j in 0..t_word_vec.len()+1 {

            // Replace operation
            if i > 0 && j > 0
            {
                if s_word_vec[i-1] == t_word_vec[j-1]
                {
                    dp[[i, j]] = chmin(dp[[i, j]], dp[[i-1, j-1]]);
                }
                else
                {
                    dp[[i, j]] = chmin(dp[[i, j]], dp[[i-1, j-1]] + 1);
                }
            }

            // Delete operation
            if i > 0
            {
                dp[[i, j]] = chmin(dp[[i, j]], dp[[i-1, j]] + 1);
            }

            // Insert operation
            if j > 0
            {
                dp[[i, j]] = chmin(dp[[i, j]], dp[[i, j-1]] + 1);
            }

        }
    }
    println!("{}", dp[[s_word.len(), t_word.len()]]);

}