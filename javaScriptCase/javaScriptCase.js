function oddishOrEvenish(number) { 
    if (
        String(number) // türünü değiştiriyoruz.
            .split("") // karakterleri bir diziye atıyoruz.
            .map(Number) // dizideki her bir elemanı sayısal olarak değiştiriyoruz.
            .reduce((a, b) => a + b) % 2 === 0 // elemanların toplamının 2'ye bölümünden kalanını alıyoruz. Eğer 0 ise çift sayıdır.
    ) {
        return 'Even' // eğer çift ise 'Even' döndürüyoruz.
    } else {
        return 'Odd' // eğer tek ise 'Odd' döndürüyoruz.
    }
}

console.log(oddishOrEvenish(43)); // 'Odd'
console.log(oddishOrEvenish(373)); // 'Odd'
console.log(oddishOrEvenish(4433)); // 'Even'