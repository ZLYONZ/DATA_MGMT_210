#Task1.1
def read_ratings_data(f):
    
    ratings_dict = {}
    contents = []
    
    with open (f, 'r') as f:
        contents = f.readlines()
    f.close()
    
    for i in range(len(contents)):
        temp = contents[i][:-1].split('|')
        contents[i] = [temp[0], float(temp[1])]

    for i in contents:
        if i[0] not in ratings_dict:
            ratings_dict[i[0]] = []
        ratings_dict[i[0]].append(i[1])
    
    return ratings_dict

print(read_ratings_data('data/genreMovieTest3.txt'))

#Task1.2
def read_movie_genre(f):
    
    genre_dict = {}
    contents = []
    
    with open (f, 'r') as f:
        contents = f.readlines()
    f.close()
    
    for i in range(len(contents)):
        contents[i] = contents[i][:-1].split('|')
        
    for i in contents:
        genre_dict[i[2]] = i[0]
        
    return genre_dict

print(read_movie_genre('data/genreMovieTest3.txt'))

#Task2.1
def create_genre_dict(genre_dict):
    
    new_genre_dict = {}
    
    for i in genre_dict.keys():
        key = genre_dict[i]
        
        if not key in new_genre_dict.keys():
            new_genre_dict[key] = []
            
        new_genre_dict[key].append(i)
        
    return new_genre_dict

print(create_genre_dict(read_movie_genre('data/genreMovieTest3.txt')))

#Task2.2
def calculate_average_rating(ratings_dict):
    
    rating_avg_dict = {}
    
    for i in ratings_dict.keys():
        avg = sum(ratings_dict[i]) / len(ratings_dict[i])
        rating_avg_dict[i] = round(avg, 2)
        
    return rating_avg_dict

print(calculate_average_rating(read_ratings_data('data/movieRatingTest3.txt')))

#Task3.1
def get_popular_movies(rating_avg_dict, n = 10):
    
    pop_movies_dict = {}
    
    pop_movies_dict = dict(sorted(rating_avg_dict.items(), key=lambda item: item[1], reverse=True))
                        
    len_of_dict = len(pop_movies_dict)
    if len_of_dict <= n:
        return pop_movies_dict
    else:
        return dict(list(pop_movies_dict.items())[0:n])
                           
print(get_popular_movies(calculate_average_rating(read_ratings_data('data/movieRatingTest3.txt'))))

#Task3.2
def filter_movies(rating_avg_dict, threshold_rating = 3):
    
    filter_movies_dict = {}
    
    for key, value in rating_avg_dict.items():
        if value >= threshold_rating:
            filter_movies_dict[key] = value
            
    return filter_movies_dict

print(filter_movies(calculate_average_rating(read_ratings_data('data/movieRatingTest3.txt'))))
    
#Task3.3
def get_popular_in_genre(genre, new_genre_dict, rating_avg_dict, n = 5):

    pop_genre_dict = {}
    
    for i in new_genre_dict[genre]:
        pop_genre_dict[i] = rating_avg_dict[i]
    return dict(sorted(pop_genre_dict.items(), key=lambda item: item[1], reverse=True))
    
    len_of_dict = len(pop_genre_dict)
    if len_of_dict <= n:
        return pop_genre_dict
    else:
        return dict(list(pop_genre_dict.items())[0:n])
    
print(get_popular_in_genre('Comedy', create_genre_dict(read_movie_genre('data/genreMovieTest3.txt')), calculate_average_rating(read_ratings_data('data/movieRatingTest3.txt'))))

#Task3.4
def get_genre_rating(genre, new_genre_dict, rating_avg_dict):
    
    pop_genre_dict = {}
    genre_rating_dict = 0
    
    for i in new_genre_dict[genre]:
        pop_genre_dict[i] = rating_avg_dict[i]
    
    dict(sorted(pop_genre_dict.items(), key=lambda item: item[1], reverse=True))
    
    avg = sum(pop_genre_dict.values()) / len(pop_genre_dict.values())
    genre_rating_dict = round(avg, 2)
        
    return genre_rating_dict

print(get_genre_rating('Comedy', create_genre_dict(read_movie_genre('data/genreMovieTest3.txt')), calculate_average_rating(read_ratings_data('data/movieRatingTest3.txt'))))
    
#Task3.5
def genre_popularity(new_genre_dict, rating_avg_dict, n = 5):
    
    popularity_dict = []
    
    for genre in new_genre_dict.keys():
        rating = get_genre_rating(genre, new_genre_dict, rating_avg_dict)
        popularity_dict.append((genre, rating))
    
    popularity_dict= sorted(popularity_dict, key=lambda item: item[1], reverse=True)
            
    return dict(popularity_dict[0:n])

print(genre_popularity(create_genre_dict(read_movie_genre('data/genreMovieTest3.txt')), calculate_average_rating(read_ratings_data('data/movieRatingTest3.txt'))))

#Task 4.1
def read_user_ratings(f):
    
    user_dict = {}

    with open (f, 'r') as f:
        contents = f.readlines()
    f.close()

    for i in range(len(contents)):
        temp = contents[i][:-1].split('|')
        contents[i] = [temp[0], float(temp[1]), int(temp[2])]

    for i in contents:
        if i[2] not in user_dict:
            user_dict[i[2]] = []
        user_dict[i[2]].append((i[0], i[1]))

    return user_dict

print(read_user_ratings('data/movieRatingTest3.txt'))

#Task 4.2
def get_user_genre(user_id, user_dict, genre_dict):
    
    user_genre_dict = {}
    top_genre = ''

    for i in user_dict[user_id]:
        
        if genre_dict[i[0]] in user_genre_dict:
            user_genre_dict[genre_dict[i[0]]].append(float(i[1]))
        else:
            user_genre_dict[genre_dict[i[0]]] = [float(i[1])]
        
    for key,value in user_genre_dict.items():
        avg = sum(value) / len(value)
        user_genre_dict[key] = round(avg, 2)
    
    user_genre_dict = sorted(user_genre_dict.items(), key = lambda item: item[1], reverse = True)

    top_genre, avg = user_genre_dict[0]   
    return top_genre

print(get_user_genre(6, read_user_ratings('data/movieRatingTest3.txt'), read_movie_genre('data/genreMovieTest3.txt')))

#Task 4.3
def recommend_movies(user_id, user_dict, genre_dict, rating_avg_dict):
    
    recommend_dict = {}

    user_id = 6

    genre = get_user_genre(user_id, user_dict, genre_dict)

    for genre in create_genre_dict(genre_dict):
        genre_movie = create_genre_dict(genre_dict)[genre]
    
    for i in genre_movie:
        for k,v in user_dict[user_id]:
            if i != k:
                recommend_movie = i
    
    recommend_dict[recommend_movie] = rating_avg_dict[recommend_movie]

    return recommend_dict

print(recommend_movies(6, read_user_ratings('data/movieRatingTest3.txt'), read_movie_genre('data/genreMovieTest3.txt'), calculate_average_rating(read_ratings_data("data/movieRatingTest3.txt"))))