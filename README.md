# Assembly Lab 8

**Encrypting using rotate operations.**

Write a procedure that performs simple encryption by rotating each plaintext byte a varying number of positions. For example, in the following array that represents the encryption key, each number indicates a left rotation:

key BYTE 6, 4, 1, 2, 7, 5, 2, 4, 3, 6.

Pass the pointer to the text string in EDX, the array size to ECX, pointer to the key array in ESI, and the direction value (0 or 1) in EBX. Assume that the key array size is 10.

Your procedure should loop through a plain text and align the key to the first 10 bytes of the message. Rotate each plain text to the left (if the value in EBX is 0) or to the right (if the value in EBX is 1) by the amount in the key array: first byte by 6, second byte by 4 etc. Then align the key to the next 10 bytes until the whole message is encrypted.

Write a program that tests your procedure by calling it twice: first time with EBX = 0 (encrypting), then with EBX = 1 (decrypting).

Output the text three times: the original, then the encrypted, then the decrypted.

Bonus 2 points: allow user to enter the text and make your program determine the length of the entered text.
