require "event_manager"

describe EventManager do
  describe ".clean_zip_code" do
    context "given empty string" do
      it "returns 00000" do
        expect(EventManager.clean_zip_code("")).to eq "00000"
      end
    end

    context "given 5 digits" do
      it "returns the 5 digits" do
        expect(EventManager.clean_zip_code("12345")).to eq "12345"
      end
    end

    context "given more than 5" do
      it "truncates to the first 5 digits" do
        expect(EventManager.clean_zip_code("123456")).to eq "12345"
      end
    end

    context "less than 5 digits" do
      it "adds zeros to the front until it becomes 5" do
        expect(EventManager.clean_zip_code("123")).to eq "00123"
        expect(EventManager.clean_zip_code("1234")).to eq "01234"
      end
    end
  end
end
