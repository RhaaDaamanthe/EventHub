    document.addEventListener('DOMContentLoaded', () => {
        const searchInput = document.querySelector('.search-input');
        const eventCards = document.querySelectorAll('.event-card-link');

        searchInput.addEventListener('keyup', (e) => {
            const query = e.target.value.toLowerCase();

            eventCards.forEach(card => {
                const titleElement = card.querySelector('.event-title');
                const locationElement = card.querySelector('.event-location');
                
                if (titleElement && locationElement) {
                    const title = titleElement.textContent.toLowerCase();
                    const location = locationElement.textContent.toLowerCase();

                    if (title.includes(query) || location.includes(query)) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                }
            });
        });
    });