const mongoose = require('mongoose');

const restaurantRaitingSchema = new mongoose.Schema({
    rating: {
        type: Number,
        min: 1,
        max: 5,
        required: true
    },
    message: {
        type: String,
        maxlength: 500 // Optional review message
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User', // User who submitted the rating
        required: true
    },
    restaurantId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Restaurant', // Room being rated
        required: true
    },
    createdAt: {
        type: Date,
        default: Date.now
    }
});

const RestaurantRating = mongoose.model('RestaurantRating', restaurantRaitingSchema);
module.exports = RestaurantRating;