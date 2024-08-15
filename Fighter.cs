namespace Promotion
{
    public class Fighter
    {
        public int Code { get; set; }
        public string FIO { get; set; }
        public string BirthDate { get; set; }
        public string Country { get; set; }
        public string Citizenship { get; set; }
        public byte Seniority { get; set; }
        public string SignDate { get; set; }
        public string EndDate { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Passport { get; set; }
        public string Address { get; set; }
        public int Wins { get; set; }
        public int Losses { get; set; }
        public double Weight { get; set; }
        public double Height { get; set; }
        public double Reach { get; set; }

        public Fighter(int code, string fio, string bdate, string country, string citizen, byte seniority, string sdate, string edate,
            string phone, string email, string pass, string address, int wins, int losses, double weight, double height, double reach)
        {
            Code = code; FIO = fio; BirthDate = bdate; Country = country; Citizenship = citizen; Seniority = seniority;
            SignDate = sdate; EndDate = edate; Phone = phone; Email = email; Passport = pass; Address = address;
            Wins = wins; Losses = losses; Weight = weight; Height = height; Reach = reach;
        }
        public Fighter() { }
    }
}
