import random
import time
import base64
import requests

input_file_github_url = ("https://api.github.com/repos/shivalkarrahul/DevOps/contents/python/guess-the-word/words.txt")
tries = 1
score = 0
attempt = 0
mask_char = '#'

req = requests.get(input_file_github_url)
if req.status_code == requests.codes.ok:
    req = req.json()
    content = base64.decodestring(req['content'])
    list_of_words = content.split("\n")
else:
    print('File was not found on Github.')
    quit()



while True:
    continue_game = raw_input("Do you want to play(yes/no)?")
    print("\n")
    if continue_game.lower() == 'yes':
        tries = 1

        random_word = random.choice(list_of_words)
        word_length = len(random_word)
        if word_length == 0:
            print("The word was 0 char long, looking for another word")
            continue

        print("The word is", word_length, "characters long. Guess the word")

        while tries <= 5:
            print("\n")
            print ("Try no", tries)

            # print(random_word)
            LetterMask = bytearray(" * " * len(random_word))
            print(LetterMask)
            mask_in_word = [random.randint(1,word_length-1), random.randint(1,word_length-1), random.randint(1,word_length-1), random.randint(1,word_length-1)]

            temp_random_word = list(random_word) 
            for idx in mask_in_word: 
                temp_random_word[idx] = mask_char 
            masked_word = ''.join(temp_random_word) 
            print("Here is the masked word = ", masked_word)

            user_input_word = raw_input("Guess the word ")
            if random_word.lower() == user_input_word.lower() :
                print("Correct Guess")
                if tries == 1:
                    score = score + 10
                elif tries == 2:
                    score = score + 8
                elif tries == 3:
                    score = score + 6
                elif tries == 4:
                    score = score + 4
                elif tries == 5:
                    score = score + 2                                    
                # print ("Current Score = ", score)

                break
            else:
                if tries != 5:
                    print("\n")
                    print("Wrong Guess, retry.")

                if tries == 5:
                    print("\n")
                    print("5 Tries over")    
                    print("The words was", random_word)
                tries = tries + 1

  

        list_of_words.remove(random_word)
        # print(list_of_words)
        print("\n") 
        attempt = attempt + 1

    elif continue_game.lower() == 'no':
        print("\n")
        print("Exiting the game")
        print("Total Attempts = ", attempt)
        total = 10 * attempt
        try:
            percent_scrore = 100.0 * score /  total
        except ZeroDivisionError as e:
            print("You did not play, give it a try")
            break    
        
        print("You scored", percent_scrore, "%")
        print ("Final Score = ", score, "out of", total)
        quit()