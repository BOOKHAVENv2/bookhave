document.addEventListener("DOMContentLoaded", () => {
    // Modal and button elements
    const userModal = document.getElementById("userModal");
    const bookModal = document.getElementById("bookModal");
    const addUserBtn = document.getElementById("addUserBtn");
    const addBookBtn = document.getElementById("addBookBtn");
    
    const userOpenBtn = document.querySelector(".users-list .list-header button");
    const bookOpenBtn = document.querySelector(".books-list .list-header button");
    
    const closeButtons = document.querySelectorAll(".close");
    
    const userTableBody = document.querySelector(".users-list tbody");
    const bookTableBody = document.querySelector(".books-list tbody");

    // 1. Open and Close User Modal
    userOpenBtn.addEventListener("click", () => {
        userModal.style.display = "block";
    });

    closeButtons.forEach(button => {
        button.addEventListener("click", () => {
            userModal.style.display = "none";
            bookModal.style.display = "none";
        });
    });

    // 2. Open and Close Book Modal
    bookOpenBtn.addEventListener("click", () => {
        bookModal.style.display = "block";
    });

    // 3. Add User Functionality
    addUserBtn.addEventListener("click", () => {
        const userID = document.getElementById("userID").value;
        const userName = document.getElementById("userName").value;
        const booksIssued = document.getElementById("booksIssued").value;
        const userStatus = document.getElementById("userStatus").value;

        if (userID && userName && booksIssued && userStatus) {
            let newRow = `<tr>
                            <td>${userID}</td>
                            <td>${userName}</td>
                            <td>${booksIssued}</td>
                            <td>${userStatus}</td>
                          </tr>`;
            userTableBody.innerHTML += newRow;
            userModal.style.display = "none"; // Close modal
        } else {
            alert("Please fill in all fields.");
        }
    });

    // 4. Add Book Functionality
    addBookBtn.addEventListener("click", () => {
        const bookID = document.getElementById("bookID").value;
        const bookTitle = document.getElementById("bookTitle").value;
        const bookAuthor = document.getElementById("bookAuthor").value;
        const availableCopies = document.getElementById("availableCopies").value;
        const bookStatus = document.getElementById("bookStatus").value;

        if (bookID && bookTitle && bookAuthor && availableCopies && bookStatus) {
            let newRow = `<tr>
                            <td>${bookID}</td>
                            <td>${bookTitle}</td>
                            <td>${bookAuthor}</td>
                            <td>${availableCopies}</td>
                            <td>${bookStatus}</td>
                          </tr>`;
            bookTableBody.innerHTML += newRow;
            bookModal.style.display = "none"; // Close modal
        } else {
            alert("Please fill in all fields.");
        }
    });

    // 5. Close modal when clicking outside of it
    window.addEventListener("click", (event) => {
        if (event.target === userModal) {
            userModal.style.display = "none";
        }
        if (event.target === bookModal) {
            bookModal.style.display = "none";
        }
    });
});
