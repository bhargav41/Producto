const { Router } = require('express');
const { addNote, getNotes, shareNote, deleteNote } = require('./notes');
const router = Router();
router.post('/add', addNote);
router.get('/all', getNotes);
router.post('/share', shareNote);
router.post('/delete', deleteNote);
module.exports = router;