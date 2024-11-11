// Wait until the DOM is fully loaded
document.addEventListener("DOMContentLoaded", () => {
    // Select all the "Cancel" buttons
    const cancelButtons = document.querySelectorAll('.cancel-btn');
    
    // Select the popup notification
    const popupNotification = document.getElementById('popupNotification');
    const popupMessage = document.getElementById('popupMessage');
    
    let selectedBookCard = null;  // To store the current book card
    
    // Add click event listeners to each cancel button
    cancelButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            // Get the book information from the parent card
            selectedBookCard = event.target.closest('.book-card');
            const bookTitle = selectedBookCard.querySelector('strong').innerText;

            // Show a confirmation popup before canceling
            const confirmation = confirm(`Are you sure you want to cancel the request for "${bookTitle}"?`);
            if (confirmation) {
                // Call the function to handle cancelation logic if confirmed
                cancelRequest(selectedBookCard);
            }
        });
    });

    /**
     * Function to handle the cancelation of a book request
     * @param {HTMLElement} bookCard - The card of the book being canceled
     */
    function cancelRequest(bookCard) {
        // Disable the pending label and the cancel button
        const pendingLabel = bookCard.querySelector('.pending');
        const cancelButton = bookCard.querySelector('.cancel-btn');

        // Update the book status to "Canceled"
        pendingLabel.innerText = 'Canceled';
        pendingLabel.style.backgroundColor = '#ff4c4c';  // Change color to red to indicate cancelation

        // Update the cancel button to reflect the canceled status
        cancelButton.innerText = 'Canceled';
        cancelButton.disabled = true;  // Disable the button to prevent further clicks
        cancelButton.style.backgroundColor = '#ccc';  // Gray out the button
        cancelButton.style.cursor = 'not-allowed';  // Change cursor to not-allowed

        // Show a popup confirming the cancelation
        showPopup(`The request for "${bookCard.querySelector('strong').innerText}" has been canceled.`);
    }

    /**
     * Function to show a popup notification
     * @param {string} message - The message to display in the popup
     */
    function showPopup(message) {
        popupMessage.innerText = message;  // Set the popup message
        popupNotification.classList.add('show');  // Show the popup

        // Hide the popup after 3 seconds
        setTimeout(() => {
            popupNotification.classList.remove('show');
            popupNotification.classList.add('hide');
        }, 3000);

        // Remove the 'hide' class after the transition ends, so it can be shown again later
        popupNotification.addEventListener('transitionend', () => {
            popupNotification.classList.remove('hide');
            popupNotification.style.display = 'none';  // Hide completely after fade out
        });
    }
});
