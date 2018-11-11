# Week 2 Exercises

1. Implement a generic Queue data structure conforming to a protocol named `QueueProtocol` having properties `isEmpty, container, count` all as `get`. **Hint:** Protocols cannot be of a generic type. In order to have generic properties or methods `associatedType T` must be included to that protocol. Note that, `T` is not a thing, it's just a naming. After adding this to the protocol, you can use that associated type for generic property of method decleration. You can check the last lecture's notes.

2. Implement a `PublicTransport` class and with that class derive `Airplane`, `Bus`, `Metro` classes by using inheritance. The main class should have a `maxSpeed`, `capacity`, `currentCapacity`, `currentSpeed`, `lineName` and a `description` of itself as its properties and `move`, `stop`, `increaseSpeed`, `loadPassengers`, `removePassengers` and `honk` methods. The derived classes may have any functionality that fits to its description. It's all up to your imagination. 

3. Write an extension to the `String` struct can return the encrypted or decrypted string using ceaser cipher. Ceaser cipher shifts the characters in a text by the given amount. Lets assume that we want to encrypt the text "ABC" shifting with 2, the result of the encryption would be "CDE". The decryption is the reverse of encryption. In order to decrypt correctly we need to know the shifting value of the encryption. **Hint:** In order to shift a character, you can use the unicode scalar value of that character which is an `UInt32`, shift by amount and then again convert it back to a character. 

4. Write a generic bubble sort algorithm extending the `Array` struct that takes an argument order as ascending or descending and returns the sorted array. Bubble sort is a simple non-efficient sorting algorithm that iterates over the array and swaps its items according to the given constraint. You can use the array's swapAt(i:, j:) method.

   Assume that we have to sort [5, 1, 4, 2] in ascending order using buble sort algorithm. The algorithm works as follows:

   Starting from the first item at index 0

   1. Is 5 greater than 1? Yes, then swap [1, 5, 4, 2]
   2. Is 5 greater than 4? Yes, then swap [1, 4, 5, 2]
   3. Is 5 greater than 2? Yes, then swap [1, 4, 2, 5]
   4. The first iteration is done, now go on with the second iteration. Is 1 greater than 4? No, remains same [1, 4, 2, 5]
   5. Is 4 greater than 2? Yes, then swap [1, 2, 4, 5]. We can already see that the array is sorted, but the algorithm goes on checking up throughout the array's length.

   **Pro Tip:** We know that when the first iteration has completed, the greatest number is at the end of the array. So, we may not want to iterate over and over again by checking up until the array's length.



Due to the late submission of exercises and the intense schedule and midterms, the answers will be posted next week (22/11/2018). You can ask me questions anytime. Good luck. Happy coding :smile:. 