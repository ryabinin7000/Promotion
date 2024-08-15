namespace Promotion
{
    public class Tournament
    {
        public string Name { get; set; }
        public string Arena { get; set; }
        public string Date { get; set; }
        public int? Attend { get; set; }
        public int? Sold { get; set; }
        public decimal? Revenue { get; set; }
        public decimal? Cash { get; set; }
        public decimal? Costs { get; set; }
        public decimal? Profit { get; set; }
        public Tournament(string name, string arena, string date, int? attend, 
            int? sold, decimal? revenue, decimal? cash, decimal? costs, decimal? profit)
        {
            Name = name; Arena = arena; Date = date; Attend = attend; Sold = sold;
            Revenue = revenue; Cash = cash; Costs = costs; Profit = profit;
        }
        public Tournament() { }
    }
}
