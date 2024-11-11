document.getElementById('save-btn').addEventListener('click', function() {
    const bookId = document.getElementById('book-id').value;
    const bookName = document.getElementById('book-name').value;
    const publisher = document.getElementById('publisher').value;
    const year = document.getElementById('year').value;
    const author = document.getElementById('author').value;
    const status = document.getElementById('status').value;

    if (bookId && bookName && author) {
        const table = document.getElementById('book-table');
        const newRow = table.insertRow();

        newRow.innerHTML = `
            <td>${bookId}</td>
            <td>${bookName}</td>
            <td>${author}</td>
            <td>10</td>
            <td>${status || 'Available'}</td>
        `;

        alert('Book added successfully!');
        clearForm();
    } else {
        alert('Please fill out the required fields.');
    }
});

document.getElementById('delete-btn').addEventListener('click', function() {
    const table = document.getElementById('book-table');
    if (table.rows.length > 1) {
        table.deleteRow(table.rows.length - 1);
        alert('Last book deleted successfully!');
    } else {
        alert('No more books to delete.');
    }
});

function clearForm() {
    document.getElementById('book-id').value = '';
    document.getElementById('book-name').value = '';
    document.getElementById('publisher').value = '';
    document.getElementById('year').value = '';
    document.getElementById('author').value = '';
    document.getElementById('status').value = '';
}
