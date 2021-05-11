const mongoose = require("mongoose");

const notesSchema = mongoose.Schema({
    title: {type: String , required: true},
    subtitle: {type: String , required: true},
    userId: {type: String, required: true},
    sharedWith: {type: [String], default: []},
    isShared: {type: Boolean, default: false},
    createdAt: {type: String, default: Date.now(), timestamp: true},
    editedAt: {type: String, default: Date.now(), timestamp: true}
})

const notes = new mongoose.model('notes', notesSchema);

module.exports = notes;