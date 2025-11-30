import svgPaths from "./imports/svg-xy4598t6xw";
import imgRectangle1 from "figma:asset/5dea5f922accec2ba1cee51599916c0eca674981.png";

function VuesaxOutlineGlobal() {
  return (
    <div className="absolute contents inset-0" data-name="vuesax/outline/global">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="global">
          <path d={svgPaths.p261e480} fill="var(--fill-0, black)" id="Vector" />
          <path d={svgPaths.p2bc02600} fill="var(--fill-0, black)" id="Vector_2" />
          <path d={svgPaths.p3fd764f0} fill="var(--fill-0, black)" id="Vector_3" />
          <path d={svgPaths.pb29df00} fill="var(--fill-0, black)" id="Vector_4" />
          <path d={svgPaths.p1a259180} fill="var(--fill-0, black)" id="Vector_5" />
          <path d="M24 0H0V24H24V0Z" fill="var(--fill-0, black)" id="Vector_6" opacity="0" />
        </g>
      </svg>
    </div>
  );
}

function DefaultOutlineGlobal() {
  return (
    <div className="relative shrink-0 size-[24px]" data-name="default/outline/global">
      <VuesaxOutlineGlobal />
    </div>
  );
}

function VuesaxOutlineArrowCircleRight() {
  return (
    <div className="absolute contents inset-0" data-name="vuesax/outline/arrow-circle-right">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="arrow-circle-right">
          <path d={svgPaths.p261e480} fill="var(--fill-0, white)" id="Vector" />
          <path d={svgPaths.p1f7280} fill="var(--fill-0, white)" id="Vector_2" />
          <g id="Vector_3" opacity="0"></g>
        </g>
      </svg>
    </div>
  );
}

function DefaultOutlineArrowCircleRight() {
  return (
    <div className="relative size-[24px]" data-name="default/outline/arrow-circle-right">
      <VuesaxOutlineArrowCircleRight />
    </div>
  );
}

export default function App() {
  return (
    <div className="bg-white min-h-screen w-full max-w-[430px] mx-auto flex flex-col">
      {/* Header */}
      <div className="px-[22px] pt-[83px] pb-[28px] flex items-start justify-between">
        <p className="font-['Ubuntu:Bold',sans-serif] leading-[normal] not-italic text-[20px] text-black text-nowrap whitespace-pre">The Restaurant</p>
        
        <div className="box-border content-stretch flex gap-[6px] h-[40px] items-center px-[14px] py-[8px] rounded-[20px]">
          <div aria-hidden="true" className="absolute border border-[#949494] border-solid inset-0 pointer-events-none rounded-[20px]" />
          <DefaultOutlineGlobal />
          <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[16px] text-black text-nowrap whitespace-pre">English</p>
        </div>
      </div>

      {/* Restaurant Image */}
      <div className="px-[22px] mb-[28px]">
        <div className="rounded-[24px] w-full aspect-[358/420] overflow-hidden">
          <img 
            alt="Restaurant table setting" 
            className="w-full h-full object-cover" 
            src={imgRectangle1} 
          />
        </div>
      </div>

      {/* Table Title */}
      <div className="px-[23px] mb-[12px]">
        <p className="font-['Ubuntu:Bold',sans-serif] leading-[normal] not-italic text-[28px] text-black text-nowrap whitespace-pre">Table 24</p>
      </div>

      {/* Description */}
      <div className="px-[23px] mb-[42px]">
        <p className="font-['Ubuntu:Regular',sans-serif] leading-[24px] not-italic text-[#949494] text-[16px]">
          Lorem ipsum dolor sit amet consectetur. Neque placerat leo dapibus aliquet velit. Amet tempor mauris volutpat egestas et dui leo in gravida. Mus mauris ut aliquam faucibus<span className="text-[#0b99ff]">...more</span>
        </p>
      </div>

      {/* Action Buttons */}
      <div className="px-[22px] mb-[19px]">
        <div className="flex gap-[12px] items-center justify-center">
          <div className="box-border content-stretch flex flex-col h-[50px] items-center justify-center px-[31px] py-[8px] relative rounded-[28px] shrink-0 w-[172px]">
            <div aria-hidden="true" className="absolute border border-[#949494] border-solid inset-0 pointer-events-none rounded-[28px]" />
            <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[#949494] text-[12px] text-center text-nowrap whitespace-pre">I'm new here</p>
            <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[18px] text-black text-center text-nowrap whitespace-pre">Chat with AI</p>
          </div>
          
          <div className="bg-white box-border content-stretch flex gap-[10px] h-[50px] items-center justify-center px-[55px] py-[17px] relative rounded-[28px] shrink-0 w-[172px]">
            <div aria-hidden="true" className="absolute border border-[#949494] border-solid inset-0 pointer-events-none rounded-[28px]" />
            <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[18px] text-black text-center text-nowrap whitespace-pre">Menu</p>
          </div>
        </div>
      </div>

      {/* Order Fast Button */}
      <div className="px-[22px] pb-[40px]">
        <div className="bg-black box-border content-stretch flex gap-[10px] h-[50px] items-center justify-center px-[134px] py-[17px] relative rounded-[28px] w-full">
          <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[18px] text-center text-nowrap text-white whitespace-pre">Order Fast</p>
          <div className="absolute right-[16px] top-1/2 -translate-y-1/2">
            <DefaultOutlineArrowCircleRight />
          </div>
        </div>
      </div>
    </div>
  );
}
