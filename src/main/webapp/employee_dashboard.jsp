<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Task Management</title>
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        /* Add your custom styles here */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 8px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <div class="wrapper">
        <main class="content">
            <div class="container-fluid p-0">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <strong class="h3 mb-3">Tickets</strong>
                            </div>
                            <div class="card-body">
                                <table id="ticketTable" class="display" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>Ticket ID</th>
                                            <th>Title</th>
                                            <th>Description</th>
                                            <th>Severity</th>
                                            <th>Assignee</th>
                                            <th>Status</th>
                                            <th>Due Date</th>
                                            <th>Updated At</th>
                                            <th>Remark</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Table rows will be populated dynamically -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Modal -->
        <div id="ticketModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <p>Modal content here...</p>
            </div>
        </div>
    </div>

    <!-- JavaScript libraries -->
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            var table = $('#ticketTable').DataTable({
                dom: 'Bfrtip', // Display buttons for export and column visibility
                buttons: [
                    {
                        extend: 'collection',
                        text: 'Export <i class="fa fa-caret-down" aria-hidden="true"></i>',
                        buttons: ['pdf', 'csv', 'excel']
                    },
                    {
                        extend: 'collection',
                        text: 'Column Visibility <i class="fa fa-caret-down" aria-hidden="true"></i>',
                        buttons: ['columnsToggle']
                    }
                ]
            });

            // Function to populate DataTable with data from API
            function populateDataTable() {
                $.ajax({
                    url: 'http://localhost:8080/v1/api/t/c', // Your API endpoint URL
                    type: 'GET',
                    dataType: 'json',
                    success: function(response) {
                        console.log(response); // Log the response to check data
                        if (response && response.status === "success") {
                            var tickets = JSON.parse(response.tickets); // Parse the tickets string to JSON array
                            if (tickets && tickets.length > 0) {
                                tickets.forEach(function(ticket) {
                                    table.row.add([
                                        ticket.ticketId,
                                        ticket.title,
                                        ticket.description,
                                        ticket.severity,
                                        ticket.assignee,
                                        ticket.status,
                                        ticket.DueDate,
                                        ticket.updatedAt,
                                        ticket.Remark
                                    ]).draw(false);
                                });
                            }
                        } else {
                            console.error('Failed to fetch tickets:', response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Failed to fetch tickets:', error);
                    }
                });
            }

            // Call function to populate DataTable on document ready
            populateDataTable();

            // Handle modal functionality
            var modal = document.getElementById("ticketModal");
            var span = document.getElementsByClassName("close")[0];

            $(document).on("click", ".ticketId", function() {
                modal.style.display = "block";
                // Example: Load modal content dynamically based on ticket ID
                var ticketId = $(this).data('ticket-id');
                // Ajax call to fetch ticket details and populate modal
                // Example:
                // $.ajax({
                //     url: 'https://your-api-url/tickets/' + ticketId,
                //     type: 'GET',
                //     dataType: 'json',
                //     success: function(response) {
                //         // Populate modal content based on response
                //     },
                //     error: function(xhr, status, error) {
                //         console.error('Failed to fetch ticket details:', error);
                //     }
                // });
            });

            // Close modal when clicking on close button (x)
            span.onclick = function() {
                modal.style.display = "none";
            };

            // Close modal when clicking outside of it
            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            };
        });
    </script>
</body>

</html>
