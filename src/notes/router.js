const { Router } = require('express');
const { addNote, getNotes, shareNote } = require('./notes');
const router = Router();
router.post('/add', addNote);
router.get('/all', getNotes);
router.post('/share', shareNote);
module.exports = router;