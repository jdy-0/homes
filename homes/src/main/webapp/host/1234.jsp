<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Image Grid with Extra Image</title>
    <style>
        .container {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 columns of equal width */
            grid-template-rows: repeat(2, 1fr);    /* 2 rows of equal height */
            gap: 10px;                            /* Gap between items */
            height: 100vh;                        /* Full viewport height */
            width: 100vw;                         /* Full viewport width */
            padding: 10px;                       /* Padding around the grid */
            box-sizing: border-box;
            position: relative;
        }

        .large-image {
            grid-column: 1 / 3;  /* Spans from column 1 to column 3 (covers 2 columns) */
            grid-row: 1 / 3;     /* Spans from row 1 to row 3 (covers 2 rows) */
            object-fit: cover;  /* Ensures the image covers its container */
            width: 100%;
            height: 100%;
        }

        .small-image {
            object-fit: cover;  /* Ensures the image covers its container */
            width: 100%;
            height: 100%;
        }

        .extra-image {
            grid-column: 3 / 5;  /* Spans from column 3 to column 5 */
            grid-row: 2 / 3;     /* Spans from row 2 to row 3 */
            object-fit: cover;  /* Ensures the image covers its container */
            width: 100%;
            height: 100%;
        }

        .preview {
            display: contents;  /* Ensures children take up the grid space directly */
        }
    </style>
</head>
<body>
    <h1>Image Grid with Extra Image</h1>
    <div class="container">
        <img src="../img/no_image.jpg"  alt="Large Image" class="large-image">
        <div class="preview">
            <!-- Images will be inserted here dynamically -->
        </div>
        <img src="../img/no_image.jpg" alt="Extra Image" class="extra-image">
    </div>

    <script>
        // Array of small image sources
        const smallImageSources = [
        	'../img/no_image.jpg',
        	'../img/no_image.jpg',
        	'../img/no_image.jpg',
        	'../img/no_image.jpg',
        	'../img/no_image.jpg',
        	'../img/no_image.jpg',
        	'../img/no_image.jpg',
        	'../img/no_image.jpg'
        ];

        const previewDiv = document.querySelector('.preview');

        // Create and insert small images into the grid
        smallImageSources.forEach(src => {
            const img = document.createElement('img');
            img.src = src;
            img.alt = 'Small Image';
            img.classList.add('small-image');
            previewDiv.appendChild(img);
        });
    </script>
</body>
</html>
